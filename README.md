# trickylog项目文档

## 依赖:

 * ruby: `2.3.0`
 * rails: `4.2.5`
 * postgresql: `9.5.1`

## pg 创建用户
```bash
  create role trickylog login password 'trick';
  create database trickylog_development with owner 'trickylog';
```

## 安装:
```bash
  bundle install --path vendor/bundle # 安装gems
  bundle exec rake db:create db:migrate # 创建schema
```

## 启动:
```bash
  bundle exec spring rails s -b 127.0.0.1 -p 3000
```
