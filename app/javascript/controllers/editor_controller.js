import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['schemaFormat', 'textArea']
  

  initialize() {
    // this.element.textContent = "Hello World!"   
    console.log('connected editor');

    this.initializeEditor();
  }


  initializeEditor(){

    if(this.textAreaTarget.CodeMirror == undefined){
      CodeMirror.fromTextArea(this.textAreaTarget, {
        mode: this.mode,
        theme: "monokai",
        lineNumbers: true,
        extraKeys: { Enter: false },
        enterMode: "indent"
      });
    } else {
    }

  }

  updateEditor(){
    this.codeMirror?.setOption('mode', this.mode);
  }

  get mode() {
    switch(this.schemaFormatTarget.value){
      case('yaml'): {
        return {name: 'yaml'};
      }
      case('csv'): {
        return {name: 'csv'}
      }
      case('markdown'): {
        return {name: 'markdown'}
      }
      case('json'): {
        return {name: 'csv', json: true, statementIndent: 2}
      }
    }

  }
}
