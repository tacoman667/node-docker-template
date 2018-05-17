# Node Docker Template

This template will get you started with how to use docker as the development environment while being able to make changes in your local environment.

NPM modules are notoriously difficult to work with in a docker container when trying to mount a volume from your local environment's application folder, to the container's application folder. There are many ways to get around it, but [`yarn`](https://yarnpkg.com/) has some features that makes it almost a non-issue.

[yarn workspaces](https://yarnpkg.com/en/docs/workspaces) allow for nested applications/modules to have their module dependencies to be installed into the main `project.json` root folder so as not to duplicate and take up storage.

[`--modules-folder`](https://yarnpkg.com/en/docs/cli/install#yarn-install---modules-folder-path-) allows for setting a different folder to hold node_modules all together. This is highly valuable when trying to mount the application root folder from the development host to the container folder, which essentially wipes out any node_modules in that path, causing the application to crash as it cannot find any required modules. It is best to put this in the `.yarnrc` file in the project root folder as seen in this template.

This template has a starter express application, a `Dockerfile`, a `docker-compose.yml`, and everything setup to get started. No need to run `yarn install` on the host, as this is all done in the container when `docker-compose up` is run in the terminal. `docker-compose` does run a shell script which also runs `yarn install`, but this is because we are moving `node_modules` to a completely different folder outside the project within the container. in doing so, `yarn install` needs to add symlinks to the folder and it's contents. those symlinks will be stored on the development host environment, but it is miniscule in size, compared to holding hundreds of npm modules.