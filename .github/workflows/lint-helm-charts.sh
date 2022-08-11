#!/bin/bash

for service in services/*
do
  helm dependency update $service
  helm lint  $service --strict
  if [ $? != 0 ]; then
      echo "Error while performing helm lint on service chart: $service"
      exit 1
  fi
done

for job in jobs/*
do
  helm dependency update $job
  helm lint $job --strict
  if [ $? != 0 ]; then
      echo "Error while performing helm lint on job chart: $job"
      exit 1
  fi
done

for usecase in usecases/*
do
  helm dependency update $usecase
  helm lint $usecase --strict
  if [ $? != 0 ]; then
      echo "Error while performing helm lint on usecase chart: $job"
      exit 1
  fi
done
