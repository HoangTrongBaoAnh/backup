<template>
  <v-list expand light dense nav>
    <v-list-group prepend-icon="mdi-book-multiple" :value="true">
      <template v-slot:activator>
        <v-list-item-title>Danh muc</v-list-item-title>
      </template>
      <v-list-item-group>
        <v-list-item
          style="padding-left: 40px"
          link
          v-for="(item, i) in categories"
          :key="i"
        >
          <NuxtLink
            :to="{
              name: 'category-slug',
              params: { slug: item.content, id: item.id },
            }"
          >
            <v-list-item-content>
              <v-list-item-title v-text="item.content"></v-list-item-title>
            </v-list-item-content>
          </NuxtLink>
        </v-list-item>
      </v-list-item-group>
    </v-list-group>

    <v-list-group :value="true" no-action prepend-icon="mdi-account-circle">
      <template v-slot:activator>
        <v-list-item-title>Category</v-list-item-title>
      </template>
      <v-list-item-group>
        <v-list-item
          style="padding-left: 40px"
          v-for="item in childcategories"
          :key="item.id"
        >
          <v-list-item-content>
            <v-list-item-title>
              <label class="form-check-label" :for="'category' + item.id">
                {{ item.title }}
              </label>
            </v-list-item-title>
          </v-list-item-content>
          <input
            :value="item.id"
            v-model="selected.child"
            :id="'category' + item.id"
            type="checkbox"
            class="form-check-input"
          />
        </v-list-item>
      </v-list-item-group>
    </v-list-group>
    <v-list-group prepend-icon="mdi-cash-multiple" :value="true" no-action>
      <template v-slot:activator>
        <v-list-item-title>Price</v-list-item-title>
      </template>
      <v-list-item-group>
        <v-list-item
          style="padding-left: 40px"
          v-for="item in prices"
          :key="'price' + item.id"
        >
          <input
            :value="item.id"
            v-model="selected.prices"
            :id="'price' + item.id"
            type="checkbox"
            class="form-check-input"
          />
          <label class="form-check-label" :for="'price' + item.id">
            {{ item.title }}
          </label>
        </v-list-item>
      </v-list-item-group>
    </v-list-group>
    <div class="v-list-group v-list-group--default v-list-group--no-action">
      <v-list-item-group>
        <v-list-item-content>
          <v-list-item-title>Publisher</v-list-item-title>
        </v-list-item-content>

        <v-list-item> </v-list-item>
      </v-list-item-group>
    </div>
  </v-list>
</template>
<script>
export default {
  name: "filterBar",
  props: ["categories", "childcategories"],
  data() {
    return {
      selected: {
        prices: [],
        child: [],
        
      },
      publishers: [],
      prices: [
        {
          id: 0,
          title: "less than 50",
        },
        {
          id: 1,
          title: "50 -> 100",
        },
        {
          id: 2,
          title: "more than 100",
        },
      ],
    };
  },
  watch: {
    selected: {
      handler: function () {
        //console.log(this.selected);
        this.$emit(
          "update-push",
          this.selected,
        );
        //updateSelected(this.selected.prices,this.selected.categories)
      },
      deep: true,
      immediate: true,
    },
  },
};
</script>
<style lang="scss">
</style>
