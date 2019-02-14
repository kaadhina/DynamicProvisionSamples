# DynamicProvisionSamples

Since Run functional test and Deploy Visual Studio test agent tasks in Azure Devops are getting deprecated, we wrote a sample using the new Visual Stusio test task to run test in parallel dynamically provisioned agents.

The sample definition essentially does the following:
+ Creates VMs on Azure.
+ Configures agents on them against a particular pool.
+ Runs tests in parallel, on the agents in the above pool.
+ Unconfigures the agents from the pool.
+ Deletes the VMs

Please note that the test pool need to be unique for a particular definition and cannot be reused across runs. You may eother use unique pools or modify the script to add a unique capability in the agents to ensure reuse of pools.

The templates and scripts used here are just samples to help you get started with the scenario. Feel free to modify orcustomize them as per your need.