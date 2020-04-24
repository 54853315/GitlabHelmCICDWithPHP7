# Github CICD + Helm部署PHP7最佳实践

为了让研发团队快速持续迭代PHP项目，采用Dockerfile(Nginx+PHP7.2+supervisor)+Helm部署的方式实现CICD。

## 目录说明

`devops`目录为程序部署至集群提供了参考。

`stack`目录为PHP程序自动化构建与部署提供了参考，里边包含了CICD所需的`gitlab-ci.yml`以及`Dockerfile`，还有相关的服务组件配置（`/Config`），`/Charts`是为Helm Repo服务。

## 相关工具说明

- Harbor企业级镜像中心：使用docker-compose部署，版本 1.10.0
- GitLab：使用docker部署，版本 12.5.2
- Gitlab-Runner：使用docker部署，版本 latest
- Helm：kubernetes包管理工具，版本 3.0.0-rc2
- PHP7.2-alpine

## 使用步骤

请阅读[博客文章](https://blog.crazyphper.com/2020/04/24/gitlab-runnerhelm%e5%ae%9e%e7%8e%b0php%e7%a8%8b%e5%ba%8f%e5%9c%a8k8s%e7%9a%84%e8%87%aa%e5%8a%a8%e5%8c%96%e6%9e%84%e5%bb%ba%e4%b8%8e%e9%83%a8%e7%bd%b2)。

文章目录：
- Runner配置
- 文件结构介绍
- Helm
- gitlab-ci.yml
- Dockerfile
- Nginx
- PHP
- Superivisor
- [注意事项](https://blog.crazyphper.com/2020/04/24/gitlab-runnerhelm%e5%ae%9e%e7%8e%b0php%e7%a8%8b%e5%ba%8f%e5%9c%a8k8s%e7%9a%84%e8%87%aa%e5%8a%a8%e5%8c%96%e6%9e%84%e5%bb%ba%e4%b8%8e%e9%83%a8%e7%bd%b2/#mdx-toc-0)

## 测试

```
docker build -t name .
docker run -p 8855:80 name 
curl http://localhost:8855
```

## 作者

[konakona](https://blog.crazyphper.com/about/)

