import React from 'react';
import { withComponentFeatures } from 'universal-dashboard';

import Embed from '@editorjs/embed'
import Table from '@editorjs/table'
import Paragraph from '@editorjs/paragraph'
import List from '@editorjs/list'
import Warning from '@editorjs/warning'
import Code from '@editorjs/code'
import LinkTool from '@editorjs/link'
import Image from '@editorjs/image'
import Raw from '@editorjs/raw'
import Header from '@editorjs/header'
import Quote from '@editorjs/quote'
import Marker from '@editorjs/marker'
import CheckList from '@editorjs/checklist'
import Delimiter from '@editorjs/delimiter'
import InlineCode from '@editorjs/inline-code'
import SimpleImage from '@editorjs/simple-image'
import EditorJs from 'react-editor-js';
import Parser from '@son_xx/editor-js-parser'

const EDITOR_JS_TOOLS = {
  embed: Embed,
  table: Table,
  paragraph: Paragraph,
  list: List,
  warning: Warning,
  code: Code,
  linkTool: LinkTool,
  image: Image,
  raw: Raw,
  header: Header,
  quote: Quote,
  marker: Marker,
  checklist: CheckList,
  delimiter: Delimiter,
  inlineCode: InlineCode,
  simpleImage: SimpleImage
}

const UDEditor = (props) => {
  const save = (api, data) => {
    if (props.onChange) {
      let myData = data;
      if (props.format === "html") {
        myData = Parser(data.blocks)
      }
      props.onChange(myData);
    }
  }

  return (
    <>
      <EditorJs data={props.data} tools={EDITOR_JS_TOOLS} onChange={save} />
    </>
  )
}

export default withComponentFeatures(UDEditor);