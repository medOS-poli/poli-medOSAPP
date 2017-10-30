function get(url, callback)
{
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url+"?nick="+userName.text+"&password="+password.text, true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("authorization", pane.secret);

    xhr.onreadystatechange = function ()
    {
        if(xhr.readyState == XMLHttpRequest.DONE)
            callback(xhr);
    };

    var data = { "nick":userName.text , "password":password.text }
    xhr.send(null);
}

function post(url, callback)
{
    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function()
    {//Call a function when the state changes.
        if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
        {
            callback(xhr);
        }
    }

    xhr.open('POST', url, true);
    xhr.setRequestHeader("Content-type", "application/json;charset=UTF-8");

    var data = { "nick":userName.text , "password":password.text }

    xhr.send(JSON.stringify(data));
}
