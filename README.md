# Directus CMS Template

[//]: # (Uncomment following lines when setting up in project. Make sure you edit the front matter at the bottom of this README)
[//]: # ([![Deploy Production CMS]][DeployProd]  )
[//]: # (![deploy_screenshot.png]&#40;deploy_screenshot.png&#41;)

This repo contains the Directus CMS, which is a headless CMS that provides a clean and easy-to-use interface for
managing your content.
Set up this template in your project by executing the following degit command from your project root:
```bash
npx degit clarity-digital/directus-template directus
```
Copy the GitHub action from the `github-action-examples` folder
```bash
cp -r ./directus/github-action-examples/.github ./.github
```

## Development

To make the CMS locally available for development at `http://localhost:8055`, follow these steps:

1. ```bash
   cp .env.example .env
   ```
2. ```bash
   npm install
   ```
3. ```bash
   npm run start
   # or
   docker compose up -d
   ```
4. ```bash
   npm run apply
   ```
   
The CMS is now available at `http://localhost:8055` with the default login credentials set in the `.env` file.

You can make changes to the CMS using the admin account in the UI at the provided URL.
When you want are satisfied with your changes you can create a new snapshot.
```bash
npm run create-snaphot
```
This will create a new snapshot in the `snapshots` directory.
You can then commit this snapshot to the repository, and it will be deployed to staging when it is merged to `develop` and a new PR is opened to `main`.  
Alternatively you can try to deploy the CMS to the staging environment manually by following the instructions in [Deployment - Staging](#staging) and then pushing the changes to the `develop` branch.

## Deployment

### Staging

The Directus CMS is automatically deployed to the staging environment when a pull request is opened from `develop`
to `main`.
This ensures that the CMS is always up-to-date with the latest changes and a clear branch can be tracked to know what is
deployed and changes can be tested before they are deployed to production.
The github action at `.github/workflows/stage-cms-deployment.yml` is responsible for this.
A DigitalOcean droplet is used to host the staging environment which has NVM, and Docker set up on the develop branch.
To manually update the staging environment, follow these steps similar to what the github action does:
1. Make sure your SSH key is added to the authorized keys on the DigitalOcean droplet.
2. ```bash
   ssh root@[staging-droplet-ip or domain]
   ```
3. ```bash
   cd ~/directus
   ```
4. ```bash
   git pull
   ```
   4. ```bash
      git checkout feat/new-feature-branch-to-stage 
      ```
5. ```bash
   nvm use
   ```
6. ```bash
   npm run start
   # or
   docker compose up -d
   ```
7. ```bash
   npm run apply
   ```
8. The CMS is now available

### Production
The deployment of production is set up in the same way as the staging environment, but the deployment is done with a manual workflow trigger or by performing the same steps as above for `root@cms.bandbewust.nl`.
1. Make sure your SSH key is added to the authorized keys on the DigitalOcean droplet.
2. ```bash
   ssh root@[production-droplet-ip or domain]
   ```
3. ```bash
   cd ~/directus
   ```
4. ```bash
   git pull
   ```
   4. ```bash
      git checkout feat/new-feature-branch-to-stage 
      ```
5. ```bash
   nvm use
   ```
6. ```bash
   npm run start
   # or
   docker compose up -d
   ```
7. ```bash
   npm run apply
   ```
8. The CMS is now available

### Help
If you have an environment set up with a database and directus container but directus is not installed correctly in the database, run
```bash
npm run bootstrap
# or
docker compose exec directus npm run bootstrap
```
This will install the directus tables in the database and you can then run `npm run apply` to latest snapshot the changes to the database.

<!----------------------------------------------------------------------------->
[DeployProd]: https://github.com/clarity-digital/[Update-with-correct-repo-name]/actions/workflows/production-cms-deployment.yml 'Create new action from workflow to deploy changes from CMS to Production'
<!---------------------------------[ Buttons ]--------------------------------->
[Deploy Production CMS]: https://img.shields.io/badge/Click_to_deploy-Production_CMS-blue
