#!/bin/bash

echo -e "\n\n Assuming this script will be run inside helm charts repo with harbor configuration being done."

VERSION=${VERSION:-v5.1.0}
TIMEOUT=${TIMEOUT:-60}

for service in services/*
do
  helm package -u $service --version=$VERSION
  if [ $? != 0 ]; then
      echo "failed to package $service"
      exit 1
  fi
done

for job in jobs/*
do
  helm package -u $job --version=$VERSION
  if [ $? != 0 ]; then
      echo "failed to package $job"
      exit 1
  fi
done

for usecase in usecases/*
do
  helm package -u $usecase --version=$VERSION
  if [ $? != 0 ]; then
      echo "failed to package $usecase"
      exit 1
  fi
done

for chart in ./*.tgz; do
    helm cm-push -t $TIMEOUT $chart isecl-helm
    if [ $? != 0 ]; then
      echo "failed to push chart $chart"
      exit 1
    fi
done
