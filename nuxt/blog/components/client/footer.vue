<template>
  <v-footer dark padless>
    <v-card flat tile width="100%" class="white--text text-center">
      <div class="row" style="margin:0">
        <div class="col-4">
          <v-card-text>
            <div
              class="text-left px-2"
              style="border-right: 1px solid white; height: 90%"
            >
              <h1 class="pb-2 white--text">You can find us at</h1>
              <p>
                <span>{{ des }}</span>
              </p>
              <a v-bind:href="social.url" v-for="social in socials">
                <v-btn class="mx-4 white--text" icon>
                  <v-icon size="24px">{{ social.icon }}</v-icon>
                </v-btn>
              </a>
              <div class="mb-4"></div>
            </div>
          </v-card-text>
        </div>
        <div class="col-8">
          <v-card-text class="pt-0 text-left text-md-left">
            <v-expansion-panels accordion v-model="panel" multiple>
              <v-expansion-panel
                v-for="(item, i) in items"
                :key="i"
                class=" col-md-4 col-12 elevation-0 "
              >
                <h3 class="d-none d-md-block py-1">{{ item.name }}</h3>
                <v-expansion-panel-header class="d-md-none">{{
                  item.name
                }}</v-expansion-panel-header>
                <li v-for="tag in item.tags">
                  <a v-bind:href="tag.url" class="white--text"
                    >{{ tag.urlname }}
                  </a>
                </li>
              </v-expansion-panel>
            </v-expansion-panels>
          </v-card-text>
        </div>
      </div>

      <v-divider></v-divider>

      <v-card-text class="white--text">
        Copyright 1993 - {{ new Date().getFullYear() }}
        <a class="white--text" href="https://codepen.io/jettaz">Jettaz</a> | It
        is free for use
      </v-card-text>
    </v-card>
  </v-footer>
</template>
<script>
export default {
  data() {
    return {
      panel: [],
      socials: [
        { name: "facebook", icon: "mdi-facebook", url: "#!" },
        { name: "twitter", icon: "mdi-twitter", url: "#!" },
        { name: "google", icon: "mdi-google", url: "#!" },
        { name: "linkedin", icon: "mdi-linkedin", url: "#!" },
        { name: "instagram", icon: "mdi-instagram", url: "#!" }
      ],
      items: [
        {
          name: "Product",
          tags: [
            {
              urlname: "Create Websites",
              url: "#!"
            },
            {
              urlname: "Secure Cloud Hosting",
              url: "#!"
            },
            {
              urlname: "Engage Your Audience",
              url: "#!"
            },
            {
              urlname: "Website Support",
              url: "#!"
            }
          ]
        },
        {
          name: "Company",
          tags: [
            { urlname: "About", url: "#!" },
            { urlname: "Careers", url: "#!" },
            { urlname: "Support", url: "#!" },
            { urlname: "Pricing", url: "#!" },
            { urlname: "FAQ", url: "#!" }
          ]
        },
        {
          name: "Resources",
          tags: [
            { urlname: "Blog", url: "#!" },
            { urlname: "eBooks", url: "#!" },
            { urlname: "Whitepapers", url: "#!" },
            { urlname: "Comparison Guide", url: "#!" },
            { urlname: "Website Grader", url: "#!" }
          ]
        }
      ],
      des:
        "Fahasa.com nhận đặt hàng trực tuyến và giao hàng tận nơi. KHÔNG hỗ trợ đặt mua và nhận hàng trực tiếp tại văn phòng cũng như tất cả Hệ Thống Fahasa trên toàn quốc."
    };
  },
  beforeDestroy() {
    if (typeof window !== "undefined") {
      window.removeEventListener("resize", this.onResize, { passive: true });
    }
  },

  mounted() {
    this.onResize();
    window.addEventListener("resize", this.onResize, { passive: true });
  },

  methods: {
    onResize() {
      if (window.innerWidth >= 960) {
        this.panel = [...Array(4).keys()].map((k, i) => i);
      } else {
        this.panel = [];
      }
    }
  }
};
</script>
<style>
@media (min-width: 960px) {
  .v-expansion-panel:before {
    box-shadow: none !important;
  }
  .v-expansion-panel:not(:first-child)::after {
    border-top: none;
  }
}
.resize {
  text-align: center;
}
.resize {
  margin-top: 3rem;
  font-size: 1.25rem;
}
/*RESIZESCREEN ANIMATION*/
.right {
  animation: rightanime 1s linear infinite;
}

.left {
  animation: leftanime 1s linear infinite;
}
@keyframes rightanime {
  50% {
    transform: translateX(10px);
    opacity: 0.5;
  }
  100% {
    transform: translateX(10px);
    opacity: 0;
  }
}
@keyframes leftanime {
  50% {
    transform: translateX(-10px);
    opacity: 0.5;
  }
  100% {
    transform: translateX(-10px);
    opacity: 0;
  }
}
</style>
