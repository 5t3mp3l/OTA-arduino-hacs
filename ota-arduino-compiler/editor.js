<div id="editor" style="width: 100%; height: 400px;"></div>
<script>
  require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.31.1/min/vs' }});
  require(['vs/editor/editor.main'], function() {
    var editor = monaco.editor.create(document.getElementById('editor'), {
      value: `// Write your Arduino code here...`,
      language: 'cpp',
      theme: 'vs-dark'
    });

    function saveCode() {
      const code = editor.getValue();
      console.log(code);
    }

    document.getElementById("save-button").onclick = saveCode;
  });
</script>
