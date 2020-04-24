# helm情况介绍

关于`admin-frontend`、`frontend`，这几个文件夹是helm插件所需要的项目配置，用于执行`helm install`和`helm upgrade`命令的。它们可以只存在于各自的git仓库，也可以统一放在这里（好处是集中安装）。

集中安装时，只需要进入`/env/[production|staging|testing]/`目录下，按照`README.md`执行命令即可，而更新操作则在各个端的仓库里执行。

由于`backend`仓库执行`helm upgrade`命令时，往往因为数据库的密码不同，需要用`-f`指定不同的`[testing|staging]_values.yaml`，因此这几个values文件需要放在各个端的仓库中，供CICD自动化部署时调用。

只有生产环境的`values.yaml`（位于`/env/production/services/backend/values.yaml`）可以放在devops这边，因为生产环境是手动部署的，不依赖CICD。

