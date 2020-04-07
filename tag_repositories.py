#!/usr/bin/env python
import datetime
import time
from urllib import request
from urllib.parse import urlencode
import json
import sys


BASE_GITLAB_URL = 'https://gitlab.insight-centre.org/api/v4/'
PROJECTS_ENDPOINT = 'projects'
REPOSITORY_TAGS_ENDPOINT = 'projects/{project_id}/repository/tags'


def build_url(base, endpoint, params=None):
    url = base + endpoint
    if params is not None:
        params = urlencode(params)
        return url + '?' + params
    return url


def get_project_id_by_name(access_token, project_name):
    search_project_url = build_url(
        BASE_GITLAB_URL,
        PROJECTS_ENDPOINT,
        params={'search': f'SIT/mps/{project_name}'}
    )
    response = make_request_get(access_token, search_project_url)
    content = response.read().decode('utf8')
    data = json.loads(content)
    assert len(data) > 0
    for proj in data:
        if proj['path'] == project_name:
            return proj['id']
    raise Exception(f'Could not find project id for : "{project_name}"')


def make_tag(access_token, project_id, tag):
    make_tag_url = build_url(
        BASE_GITLAB_URL,
        REPOSITORY_TAGS_ENDPOINT.format(project_id=project_id)
    )
    response = make_request_post(access_token, make_tag_url, data={'tag_name': tag, 'ref': 'master'})
    content = response.read().decode('utf8')
    data = json.loads(content)
    assert len(data) > 0
    return data


def make_request_get(access_token, url):
    req = request.Request(url,
                          headers={'content-type': 'application/json', 'PRIVATE-TOKEN': access_token})
    response = request.urlopen(req)
    return response


def make_request_post(access_token, url, data):
    if data is None:
        params = None
    else:
        params = json.dumps(data).encode('utf8')
    req = request.Request(url, data=params, headers={'content-type': 'application/json', 'PRIVATE-TOKEN': access_token})
    response = request.urlopen(req)
    return response


def run(access_token, project_name, tag):
    project_id = get_project_id_by_name(access_token, project_name)
    try:
        tag_info = make_tag(access_token, project_id, tag)
    except:
        raise Exception(f"Could not create tag for project: '{project_name}'")
    else:
        print(f'Tag "{tag}" created for project "{project_name}"')
        print(f'- Commit id:"{tag_info["commit"]["short_id"]}"')


if __name__ == '__main__':
    access_token = sys.argv[1]
    project_name = sys.argv[2]
    tag = sys.argv[3]
    result = run(access_token, project_name, tag)
