#! /usr/bin/env python3
import getopt
import sys
from requests import Session
from time import sleep


class LoginFailure(Exception):
    pass


class RequestFailure(Exception):
    pass

class NotFound(Exception):
    pass

class SonarResultClient:
    payload = ""
    DEFAULT_BASE_URL = "http://development.bermuda.de/sonar"

    def __init__(self, base_url=None, username=None, password=None, token=None):
        self.base_url = (base_url if base_url is not None else self.DEFAULT_BASE_URL)
        self.session = Session()
        if token is not None:
            self.tokenLogin(token)
        else:
            self.login(username, password)

    def __getResult(self, payload):
        request = self.session.get(self.base_url + "/api/qualitygates/project_status", params=payload)
        if request.ok:
            json = request.json()
            return json.get('projectStatus').get('status')
        else:
            raise RequestFailure

    def getResult(self, projectKey):
        payload = {'projectKey': projectKey}
        return self.__getResult(payload)

    def getTaskResult(self, taskId):
        payload = {'id': taskId}
        request = self.session.get(self.base_url + "/api/ce/task", params=payload)
        if request.ok:
            json = request.json()
            result =  json.get('task').get('status')
            if result == "SUCCESS":
                analysis_id = json.get('task').get('analysisId')
                return self.__getResult({'analysisId': analysis_id})
            else:
                raise NotFound
        else:
            raise RequestFailure

    def tokenLogin(self, token):
        self.session.auth = (token, '')
        
    def login(self, username, password):
        parameter = {'login': username, 'password': password}
        request = self.session.post(self.base_url + "/api/authentication/login", data=parameter)
        if not request.ok:
            raise LoginFailure("Token not valid")


def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hB:u:p:t:k:r:", ["help", "Base=", "user=", "password=", "token=",
                                                                 "projectKey=", "task="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print(err)  # will print something like "option -a not recognized"
        usage()
        sys.exit(2)
    base_url = None
    username = None
    password = None
    token = None
    task_id = None
    project_key = None

    for option, argument in opts:
        if option in ("-h", "--help"):
            usage()
            sys.exit(0)
        elif option in ("-B", "--Base"):
            base_url = argument
        elif option in ("-u", "--user"):
            username = argument
        elif option in ("-p", "--password"):
            password = argument
        elif option in ("-t", "--token"):
            token = argument
        elif option in ("-k", "--projectKey"):
            project_key = argument
        elif option in ("-r", "--task"):
            task_id = argument
        else:
            assert False, "unhandled option: " + option
    sonar_result_client = SonarResultClient(base_url=base_url, username=username,
                                            password=password, token=token)
    if task_id is None:
        result = sonar_result_client.getResult(project_key)
        print(result)
    else:
        success = False
        while not success:
            try:
                result = sonar_result_client.getTaskResult(task_id)
                success = True
                print(result)
            except NotFound:
                print("TaskId '{0}' not found. sleeping 5 seconds".format(task_id))
                sleep(5)


def usage():
    print("Usage:")
    print("{0} [-h|--help][-B|--Base=<base Url>][-u|--user=<username>][-p|--password=<password>][-t|--token=<token>]"
          "[-k|--projectKey=<projectKey>][-r|--task]\n".format(sys.argv[0]))
    print("\t-h|--help\t\tPrint this help")
    print("\t-B|--base\t\tSet Base URL (like http://sonarqube.io/sonarqube")
    print("\t-u|--user\t\tSet the username to authenticate with")
    print("\t-p|--password\tSet the password of the user")
    print("\t-t|--token\t\tSet the usertoken to authenticate")
    print("\t-k|--projectKey\t\tSet the project key to retrieve")
    print("\t-t|--task\t\tGet the result from a specific task")


# If used as script.
if __name__ == '__main__':
    main()
