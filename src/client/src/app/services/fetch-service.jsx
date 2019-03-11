import {getApiPath} from 'config'

export const fetchGet = function(url, success, history) {
    fetch(getApiPath() + url, {
        credentials: 'include'
    })
    .then(function(response){
        if (response.status === 401 && history) {
            history.push("/login");
            throw new Error('Redirecting to login');
        } else if (response.status === 200) {
            response.text().then(text => {
                try 
                {
                    return JSON.parse(text);    
                }
                catch 
                {
                    return text;   
                }
            }).then(success);
        } else {
            throw new Error(response.statusText);
        }
    })
    .catch(function(e) {
        console.log(e)
    });
}

export const fetchPost = function(url, data, success) {
    if (!success) {
        success = () => {}
    }

    fetch(getApiPath() + url, {
        method: 'post',
        headers: {
          'Accept': 'application/json, text/plain, */*',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data),
        credentials: 'include'
      })
      .then(function(response){
        if (response.status === 200) {
            return response.json();
        } else {
            throw new Error(response.statusText);
        }
    })
    .then(success)
    .catch(function(e) {
        console.log(e)
    });
}

export const fetchPostRaw = function(url, data, success) {
    if (!success) {
        success = () => {}
    }

    fetch(getApiPath() + url, {
        method: 'post',
        headers: {
          'Accept': 'application/json, text/plain, */*',
          'Content-Type': 'text/plain'
        },
        body: data,
        credentials: 'include'
      })
      .then(function(response){
        if (response.status === 200) {
            return response.text();
        } else {
            throw new Error(response.statusText);
        }
    })
    .then(success)
    .catch(function(e) {
        console.log(e)
    });
}