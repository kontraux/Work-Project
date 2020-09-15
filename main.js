const {app, BrowserWindow} = require('electron') 
const url = require('url') 
const path = require('path')  
const { timeStamp, console } = require('console')
const fs = require('fs')
const { ENGINE_METHOD_PKEY_ASN1_METHS } = require('constants');
let win  

function createWindow() { 
   win = new BrowserWindow({width: 800, height: 600}) 
   win.loadURL(url.format ({ 
      pathname: path.join(__dirname, 'index.html'), 
      protocol: 'file:', 
      slashes: true 
   })) 
}  

var spawn = require("child_process").spawn;

var exec = require('child_process').execFile;
/**
 * Function to execute exe
 * @param {string} fileName The name of the executable file to run.
 * @param {string[]} params List of string arguments.
 * @param {string} path Current working directory of the child process.
 */
function execute(fileName, params, path) {
    let promise = new Promise((resolve, reject) => {
        exec(fileName, params, { cwd: path }, (err, data) => {
            if (err) reject(err);
            else resolve(data);
        });

    });
    return promise;
}

app.on('ready', createWindow) 