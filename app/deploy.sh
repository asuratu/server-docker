#!/bin/bash
repo=git@codeup.aliyun.com:611e180776b0c8e58d793ed6/Appcoach_Server/hulk/server/hulk-server.git
dir=releases/$(date +%Y%m%d%H%M%S)
shared=shared
uploads=$shared/uploads
config=$shared/config
env=$config/.env
env_local=$config/.env.local
env_staging=$config/.env.staging
env_production=$config/.env.production

makefile() {
  path=$1
  mf=makefile
  mf_path="$path"/$mf
  cp -f ${mf}.in "$mf_path"

  if [ "$2" == "prod" ]; then
    dev="--no-dev"
  fi

  uname=$(uname -v)
  os=${uname:0:6}
  case ${os} in
  'Darwin')
    sed -i '' "s/%dev%/$dev/g" "$mf_path"
    sed -i '' 's/%webuser%/staff/g' "$mf_path"
    ;;
  *)
    sed -i "s/%dev%/$dev/g" "$mf_path"
    sed -i 's/%webuser%/www-data/g' "$mf_path"
    ;;
  esac
  return 0
}

# git
git clone $repo "$dir" || exit 1

# makefile
case $1 in
  'dev')
    makefile "$dir" dev
    ;;
  *)
    makefile "$dir" prod
    ;;
esac

# env
if [ ! -f $env ]; then
  touch $env
fi
if [ ! -f $env_local ]; then
  touch $env_local
fi
if [ ! -f $env_staging ]; then
  touch $env_staging
fi
if [ ! -f $env_production ]; then
  touch $env_production
fi
(cd "$dir" || exit;ln -sf ../../shared/config/.env .env)
(cd "$dir" || exit;ln -sf ../../$env .env)
(cd "$dir" || exit;ln -sf ../../$env_local .env.local)
(cd "$dir" || exit;ln -sf ../../$env_staging .env.staging)
(cd "$dir" || exit;ln -sf ../../$env_production .env.production)

# uploads
chown -R www-data:www-data $uploads
(cd "$dir/public" || exit;ln -sf ../../../$uploads uploads)

# make
(cd "$dir" && make) || exit 1

# current link
(rm -rf current && ln -sf "$dir" current)

# logs link
(rm -rf logs && ln -sf "$dir"/storage/logs logs)
