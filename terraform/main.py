#!/bin/python3

from __future__ import annotations
from abc import ABC, abstractmethod
import subprocess

class Strategy(ABC):

    def __init__(self, module, environment) -> None:
        self.module = module
        self.environment = environment
        self.var_file_path = f'modules/{self.module}/variables/{self.environment}.tfvars'

    @abstractmethod
    def execute(self, module: str, action: str, environment: str) -> None:
        raise NotImplementedError("Subclasses must implement this method")

class DockerStrategy(Strategy):
    def execute(self, action: str, environment: str) -> subprocess.CompletedProcess[bytes]:
        print(f"Docker - {environment.capitalize()} - Performing action: {action}")
        subprocess.run(f'terraform {action} -var-file="{self.var_file_path}"')

class AwsStrategy(Strategy):
    def execute(self, action: str, environment: str) -> subprocess.CompletedProcess[bytes]:
        print(f"AWS - {environment.capitalize()} - Performing action: {action}")
        subprocess.run(f'terraform {action} -var-file="{self.var_file_path}"')
        
class VercelStrategy(Strategy):
    def execute(self, action: str, environment: str) -> subprocess.CompletedProcess[bytes]:
        print(f"Vercel - {environment.capitalize()} - Performing action: {action}")
        subprocess.run(f'terraform {action} -var-file="{self.var_file_path}"')

class Context:
    def __init__(self, strategy: Strategy) -> None:
        self._strategy = strategy

    @property
    def strategy(self) -> Strategy:
        return self._strategy

    @strategy.setter
    def strategy(self, strategy: Strategy) -> None:
        self._strategy = strategy

    def perform_action(self, action: str, environment: str) -> None:
        self._strategy.execute(action, environment)

if __name__ == "__main__":
    module = input("Enter module (docker, aws, vercel): ")
    environment = input("Enter environment (dev, prod): ")
    action = input("Enter action (plan, apply, destroy): ")

    isEmpty = lambda x: x is None or x == ""
    environment = "dev" if isEmpty(environment) else environment

    if isEmpty(module) or isEmpty(action):
        print("Invalid module or action")
        exit(1)
    
    strategies = {
        "docker": DockerStrategy(module, environment),
        "aws": AwsStrategy(module, environment),
        "vercel": VercelStrategy(module, environment)
    }
   
    context = Context(strategies[module])
    context.perform_action(action, environment)