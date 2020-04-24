# Staging 环境

## 基本配置

| Key | Domain |
|------|-------|
| 用户前台 | https://b2EtdGVzdGluZwo.staging.yourdomain.net |
| 管理后台 | https://b2EtdGVzdGluZwo.staging.yourdomain.net/admin/ |

## 部署

创建 namespace

```
kubectl create ns yourdomain-staging
```

```
kubectl create secret docker-registry regcred --docker-server=hub.yourdomain.com --docker-username=yourusername --docker-password="***" --namespace=yourdomain-staging
```

### 部署 traefik

```
helm -n yourdomain-staging install traefik ../../helm/traefik
```

删除

```
helm -n yourdomain-staging delete traefik
```


查看端口

```
kubectl -n yourdomain-staging get svc -o wide
```


添加路由：

```
kubectl -n yourdomain-staging apply -f services/traefik/routes.yaml
```

测试：

```
$ curl https://b2EtdGVzdGluZwo.staging.yourdomain.net
404 page not found
```

### 部署服务

- 网站部署

```
helm -n yourdomain-staging install  frontend ../../helm/frontend
```

- 更新部署
```
helm upgrade --namespace yourdomain-staging -f Charts/staging_values.yaml --set image.tag=3ce6b72ca74cdacc4749494051a7055b11312cb3 --set image.repository=hub.yourdomain.com/yourdomain/frontend frontend Charts/
```
