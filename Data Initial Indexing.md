# SlideWiki deployment data initialization

## Seed data

### Seed topic tags (subjects)

    ./deployment.sh exec tagservice bin/seedTopicTags

## Solr Indexing

### Search Service

    ./deployment.sh exec searchindexer bin/delete
    ./deployment.sh exec searchindexer bin/index

This will update the solr search service index.

### NLP Store

    ./deployment.sh exec searchindexer bin/delete
    ./deployment.sh exec searchindexer bin/scheduleJobs

This will add nlp update tasks to a background jobs processing queue to limit resources spending.

## LRS

### Create admin user

In order to login into the https://learninglocker.slidewiki.org for the first time, we need to create a site admin user:

	./deployment.sh exec learninglockerapi node cli/dist/server createSiteAdmin [email] SlideWiki [password]


### Setup keys and redeploy

1. Login as admin and open SlideWiki organisation. 
2. Go to Settings -> Stores and select "Add new", name it **SlideWiki**
3. Go to Clients: a new client should have been set up for SlideWiki Store.
4. Rename it to **SlideWiki Activities Service** or similar, and check Scopes: All
5. Select "Add new" in Clients page
6. Name it **SlideWiki Platform**, and select ONLY Scopes: Read all statements

The **SlideWiki Activities Service** client will be the one used for writing statements in the SlideWiki Store. The key-secret pair should be included in .env as:

    XAPI_CLIENT_KEY
    XAPI_CLIENT_SECRET

The **SlideWiki Platform** client will be used for reading all statements from SlideWiki Store. The Basic Auth string should be included in .env as:

    SERVICE_LEARNINGLOCKER_API_AUTH

### Migrate activity data to LRS

1. pause background jobs

    ./deployment.sh stop learninglockerworker

2. copy stuff

    ./deployment.sh exec activitiesservice bin/lrs-cp

3. unpause background jobs

    ./deployment start learninglockerworker
