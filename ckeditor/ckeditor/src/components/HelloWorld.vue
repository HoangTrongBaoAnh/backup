<template>
  <div id="app">
    <ckeditor
      :editor="editor"
      v-model="editordata"
      @input="(event) => handle_change(event)"
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

import ClipBoardPlugin from "@ckeditor/ckeditor5-clipboard/src/clipboard";
import MediaEmbed from "@ckeditor/ckeditor5-media-embed/src/mediaembed";

export default {
  // props: ["modelValue"],
  //emits: ["update:modelValue"],
  props: {
    modelValue: {
      type: String,
      required: false,
    },
  },
  methods:{
    handle_change:function(event){
      //console.log(event)
      this.$emit('update:modelValue', event);
    },
     getId(url) {
  let regex = /(youtu.*be.*)\/(watch\?v=|embed\/|v|shorts|)(.*?((?=[&#?])|$))/gm;
  return regex.exec(url)[3];
}
  },
  data() {
    return {
      editor: ClassicEditor,
      editordata: this.modelValue,
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
          ClipBoardPlugin,
          MediaEmbed,
        ],
        cloudServices: {
          tokenUrl:
            "https://89901.cke-cs.com/token/dev/a3569ae970a35ac828ac570b3251fb87f9ab9d272ed044558d088f28b297?limit=10",
          uploadUrl: "https://89901.cke-cs.com/easyimage/upload/",
        },
mediaEmbed: {
                previewsInData: true,
                removeProviders: ['youtube'],
                 providers: [
                {
                    // hint: this is just for previews. Get actual HTML codes by making API calls from your CMS
                    name: 'iframely previews', 

                    // Match all URLs or just the ones you need:
                    url: /.+/,

                        html: match => {
                            const id =this.getId(match[0]);
        console.log(match)
                            return (
                                '<div style="position: relative; padding-bottom: 100%; height: 0; padding-bottom: 56.2493%;">' +
                                `<iframe src="https://www.youtube.com/embed/${ id }" ` +
                                'style="position: absolute; width: 100%; height: 100%; top: 0; left: 0;" ' +
                                'frameborder="0" allow="autoplay; encrypted-media" allowfullscreen>' +
                                '</iframe>' +
                                '</div>'
                            );
                        }
                    },
                    {
                        name: 'afreecaTV',
                        url: [
                            /^v\.afree\.ca\/ST\/([\w-]+)/,
                            /^vod\.afreecatv\.com\/([\w-]+)/,
                            /^play\.afreecatv\.com\/([\w-]+)/,
                        ],
                        html: match => {
                            const id = match[ 1 ];

                            return (
                                '<div style="position: relative; padding-bottom: 100%; height: 0; padding-bottom: 56.2493%;">' +
                                `<iframe src="https://openapi.afreecatv.com/oembed/embedinfo/${ id }" ` +
                                'style="position: absolute; width: 100%; height: 100%; top: 0; left: 0;" ' +
                                'frameborder="0" allow="autoplay; encrypted-media" allowfullscreen>' +
                                '</iframe>' +
                                '</div>'
                            );
                        }
                    },
                ]
            },
        toolbar: {
          items: [
            "bold",
            "italic",
            "link",
            "undo",
            "redo",
            "imageUpload",
            "mediaEmbed",
          ],
        },
      },
    };
  },
};
</script>