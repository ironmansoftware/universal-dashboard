import React, { useState, useRef } from 'react'
import Button from '@mui/material/Button'
import { withComponentFeatures } from 'universal-dashboard'
import LinearProgress from '@mui/material/LinearProgress';
import { FormContext } from './form';
import { Typography } from '@mui/material';
import { getDashboardId } from './../app/config.jsx'

const dashboardId = getDashboardId();

const UDUploadWithContext = (props) => {
  return (
    <FormContext.Consumer>
      {
        ({ onFieldChange }) => <UDUpload {...props} onFieldChange={onFieldChange} />
      }
    </FormContext.Consumer>
  )
}


const UDUpload = props => {
  const [loading, setLoading] = useState(false);
  const inputEl = useRef(null);
  const [file, setFile] = useState('');
  const [progress, setProgress] = useState(0);

  const handleUpload = (e) => {
    var file = inputEl.current.files[0];
    const filename = file.name;
    const chunkSize = 1024 * 1024 * 5;

    setFile(filename);

    var numberofChunks = Math.ceil(file.size / chunkSize);
    var start = 0;
    var chunkCounter = 0;
    var fileId = "";
    var chunkEnd = start + chunkSize;

    function createChunk(start, end) {
      chunkCounter++;
      chunkEnd = Math.min(start + chunkSize, file.size);
      const chunk = file.slice(start, chunkEnd);
      const chunkForm = new FormData();
      chunkForm.append('file', chunk, filename);
      uploadChunk(chunkForm, start, chunkEnd);
    }

    function updateProgress(oEvent) {
      if (oEvent.lengthComputable) {
        var percentComplete = Math.round(oEvent.loaded / oEvent.total * 100);
        var totalPercentComplete = Math.round((chunkCounter - 1) / numberofChunks * 100 + percentComplete / numberofChunks);
        setProgress(totalPercentComplete);
      }
    }

    function uploadChunk(chunkForm, start, chunkEnd) {
      var oReq = new XMLHttpRequest();
      oReq.upload.addEventListener("progress", updateProgress);
      oReq.open('post', '/api/internal/component/upload', true);
      oReq.setRequestHeader('dashboardid', dashboardId);
      if (fileId.length > 0) {
        oReq.setRequestHeader('fileid', fileId);
      }
      oReq.withCredentials = true;

      var blobEnd = chunkEnd - 1;
      var contentRange = "bytes " + start + "-" + blobEnd + "/" + file.size;
      oReq.setRequestHeader("Content-Range", contentRange);
      console.log("Content-Range", contentRange);

      oReq.onload = function (oEvent) {
        var resp = JSON.parse(oReq.response)
        fileId = resp[0];
        start += chunkSize;
        if (start < file.size) {
          createChunk(start);
        }
        else {
          var response = resp.map(x => `file:${x}`)[0];
          props.setState({
            value: response
          })
          props.onFieldChange({ id: props.id, value: response });

          if (props.onUpload) {
            props.onUpload(response);
          }

          setLoading(false);
        }
      };
      oReq.send(chunkForm);
    }

    createChunk(start);

    setLoading(true);
  }

  return (
    <div sx={{ m: 1 }} className={props.className}>
      <input
        accept={props.accept}
        id={props.id}
        type="file"
        ref={inputEl}
        multiple={props.multiple}
        onChange={handleUpload}
        sx={{ display: "none" }}
      />
      <label htmlFor={props.id}>
        <Button
          variant={props.variant}
          color={props.color}
          sx={{ bg: 'primary', color: 'text' }}
          component="span"
          disabled={loading}
        >
          <Typography>{props.text}</Typography>
        </Button>
        {loading && <LinearProgress variant="determinate" value={progress} />}
        {file && <Typography>{file}</Typography>}
      </label>
    </div>
  )
}

export default withComponentFeatures(UDUploadWithContext)