# SlideWiki Production Deployment

SlideWiki is an application that build on the principles of microservice architectures. The individual parts of the SlideWiki microservice architecture are realized as [Docker](https://www.docker.com/) containers. SlideWiki uses the [Docker Compose](https://docs.docker.com/compose/overview/) tool for deployment.


## Preparing for Deplyoment

This section explains the configurtion necessary for starting a SlideWiki deployment the first time.


### Basic configuration (.env file)

The `.env` file holds the basic configuration of the SlideWiki deployment. It defines environment variables used in the docker-compose to configure the system. In general it should be sufficient only to configure this file, changes to the compose files are only necessary when the structure of the deployment needs to be changed. In the following the individual variables will be explained:

- `SLIDEWIKI_VERSION` the version of SlideWiki to run. This determines which Docker images are use (== Tag on Docker Hub).
- `BASE_DOMAIN` sets base domain for your deployment. The Platform will be accessible under this name. The microservice will be accessible under `<service>.BASE_DOMAIN` (e.g. deckservice.mydomain.com, userservice.mydomain.com etc.).
- `LETSENCRYPT_EMAIL` email address for automatic LetsEncrypt certification.
- `LETSENCRYPT_TEST` if set to true the LetsEncrypt certification will only pull self-signed certificates. This is handy for testing purposes as this doesn't impact the LetsEncrypt certificate limits for your domain.
- `RECAPTCHA_PRIVATE_KEY` private key for ReCaptcha.
- `RECAPTCHA_PUBLIC_KEY` public key for ReCaptacha.
- `API_KEY` SlideWiki API key used for communication between Platform and User Service.
- `JWT_SERIAL` JWT Ssrial for services
- `SMTP_FROM` email address used when SlideWiki sends out registration/password reset mails.
- `SMTP_HOST`, `SMTP_PORT`, `SMTP_CLIENTNAME` hostname, port of SMTP server to use when sending mails and FQDN of sending machine (optional).
- `MAINTENANCE_DIR` directory where the backups are stored and served from (`MAINTENACE_DIR/(db|files)`). By default the logger is configured to store the logs under `MAINTENACE_DIR/log` so they are also accessible via HTTP.


### Instance Name

The `instance_name` file holds the project prefix for docker-compose. The default value is `slidewiki`. You can change it e.g. for test purposes and make the deployment use netwroks and volumes with the changed prefix, leaving your original instance untouched.

Example:
```
> echo test > instance_name

> ./start_slidewiki.sh

```
...all services, networks and volumes will be prefixed `test_`


### Protocol

SlideWiki can run in HTTP or HTTPS mode. Which protocol is used is determined by the `protocol` file.

```
> echo http > protocol

> echo https > protocol

```

### Volumes

The SlideWiki deployment uses Docker volumes as persistent storage. By default the volumes will be created as Docker volumes as part of the docker-compose start-up. However you can choose to map the volumes to directories in the `docker-compose.production` file you use for your deployment. This can be usefull e.g. if you want to store the database and files on a deadicated drive.

SlideWiki uses the following volumes in a production deployment:

- `files` uploaded user files
- `certs` TLS certificates used by NGINX
- `mongo-data` persistent storage for MongoDB
- `solr-data` persistent storage for SOLR serach index


### HTTPS

By default SlideWiki will be deployed with HTTPS enabled.

#### Automatic Certification with LetsEncrypt
By default the SlideWiki deployment will try to accquire certificates via LetsEncrypt automatically. The only thing necessary to make this work is configrating an email address in the `.env` file (LETSENCRYPT_EMAIL) and setting `LETSENCRYPT_TEST` to `false`.


#### Use Manually Obtained Certificates
In case you have TLS certificates at hand and don't want to use the automatic certification you have to comment out the `letsencrypt` service section in the `docker-compose.production.https.yml` file and then place the certificate/s and key/s into the certs volume folder, using .crt and .key extensions respectively.

For more info, please check the jwilder/nginx-proxy related [documentation](https://github.com/jwilder/nginx-proxy/blob/master/README.md#ssl-support).


### Maintenance

The maintenance image pulls nightly backups of the MongoDB and also the content of the `files` volume. The archives are stored under:

- `MAINTENANCE_DIR/db` MongoDB backups
- `MAINTENANCE_DIR/files` backups of the `files` volume

The maintenance webserver can by default be reached under `maintenance.BASE_DOMAIN`.

#### `htpasswd` for Maintenance
In order to secure your backups and logs you need to set a password that NGINX uses to restrict access to the maintenance webserver. The password file is a standard `htpasswd` file generated with the Apache server `htpasswd` tool. The password file must be named like the domain name the maintenance server will be accessible by from the internet.

Example:
```
> htpasswd -c htpasswd/maintenance.mydomain.com admin
// creates new password file and adds password for user admin

> htpasswd htpasswd/maintenance.mydomain.com developer
// adds a password for users developer to the password file
```


## Handling a Deployment

This sections gives information about various tasks that are connected to handle SlideWiki runtime deployment.


### Starting and Stopping SlideWiki

For starting the whole deplyment and stopping it there are two convenience script provided `start_slidewiki.sh` and `stop_slidewiki.sh`. Note that the scripts read the `instance_name` file for determining the project prefix used with docker-compose.

### Operations on Individual Services

The command line used with docker-compose is fairly long and bulky. The `deployment.sh` script does nothing else than giving a shorthand for calling docker-compose on the deployment.

Example:

```
> ./deployment.sh stop platform
> ./deployment.sh rm platform
> ./deployment.sh up -d platform
```

### Viewing Live Logs

The `logs.sh` script shows a live view on the log of a service. The name of the service of which the logs should be displayed must be provided as first parameter. Look into the `MAINTENANCE_DIR/logs` directory for available logs.

Example:
```
./logs.sh platform
```


### Maintenace Mode

SlideWiki's NGINX proxy can be switched into maintenace mode in which all requestes against the server are redirected to a static page that informs that the SlideWiki instance is under maintenace. The `maintenance.sh` script is used to set maintenance mode. The script prints the current status when called wihtout parameters.

Example:
```
> ./maintenance.sh on
maintenance mode

> ./maintenance.sh
maintenance mode

> ./miantenance.sh off
normal operation

> ./maintenance.sh
normal operation
```

### Re-Indexing

SlideWiki's SOLR search index can be deleted and re-indexed using the `re-index.sh` script. Depending on the number of user, slides and decks in the database this process can take some minutes.


### Thumbnail Generation
