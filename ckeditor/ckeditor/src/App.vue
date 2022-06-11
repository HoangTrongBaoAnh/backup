<template>
  <div id="app">
    <ckeditor
      :editor="editor"
      v-model="editorData"
      :config="editorConfig"
    ></ckeditor>
  </div>
</template>

<script>
import ClassicEditor from "@ckeditor/ckeditor5-editor-classic/src/classiceditor";

import EssentialsPlugin from "@ckeditor/ckeditor5-essentials/src/essentials";
import BoldPlugin from "@ckeditor/ckeditor5-basic-styles/src/bold";
import ItalicPlugin from "@ckeditor/ckeditor5-basic-styles/src/italic";
import LinkPlugin from "@ckeditor/ckeditor5-link/src/link";
import ParagraphPlugin from "@ckeditor/ckeditor5-paragraph/src/paragraph";

import EasyImagePlugin from "@ckeditor/ckeditor5-easy-image/src/easyimage";
import ImagePlugin from "@ckeditor/ckeditor5-image/src/image";
import ImageUploadPlugin from "@ckeditor/ckeditor5-image/src/imageupload";
import CloudServicesPlugin from "@ckeditor/ckeditor5-cloud-services/src/cloudservices";
export default {
  name: "app",
  data() {
    return {
      editor: ClassicEditor,
      editorData: "<p>Content of the editor.</p>",
      editorConfig: {
        plugins: [
          EssentialsPlugin,
          BoldPlugin,
          ItalicPlugin,
          LinkPlugin,
          ParagraphPlugin,
          EasyImagePlugin,
          ImagePlugin,
          ImageUploadPlugin,
          CloudServicesPlugin,
        ],
        cloudServices: {
          tokenUrl:
            "https://89901.cke-cs.com/token/dev/a3569ae970a35ac828ac570b3251fb87f9ab9d272ed044558d088f28b297?limit=10",
          uploadUrl: "https://89901.cke-cs.com/easyimage/upload/",
        },

        toolbar: {
          items: ["bold", "italic", "link", "undo", "redo", "imageUpload"],
        },
      },
    };
  },
};
</script>