function createHeaders() {
  const token = localStorage.getItem('toDoListToken');
  return {
    Accept: 'application/json',
    'Content-Type': 'application/json',
    Authorization: `Bearer ${token}`
  };
}

function checkStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  }
  const error = new Error(response.statusText);
  error.response = response;
  throw error;
}

function parseJSON(response) {
  return response.json();
}

export function httpGet(url) {
  return fetch(url, {
    headers: createHeaders(),
  })
    .then(checkStatus)
    .then(parseJSON);
}

export function httpPost(url, data) {
  const body = JSON.stringify(data);

  return fetch(url, {
    method: 'post',
    headers: createHeaders(),
    body,
  })
    .then(checkStatus)
    .then(parseJSON);
}

export function httpPostWithoutParseJson(url, data) {
  const body = JSON.stringify(data);

  return fetch(url, {
    method: 'post',
    headers: createHeaders(),
    body,
  })
    .then(checkStatus);
}


export function httpPut(url, data) {
  const body = JSON.stringify(data);

  return fetch(url, {
    method: 'put',
    headers: createHeaders(),
    body,
  })
    .then(checkStatus)
    .then(parseJSON);
}

export function httpDelete(url, data) {
  const body = JSON.stringify(data);
  return fetch(url, {
    method: 'delete',
    headers: createHeaders(),
    body
  });
}
