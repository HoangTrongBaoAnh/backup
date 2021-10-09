export const state = () => ({
  products: [],
  cart: [],
  order: [],
  user: [],
  drawerState: false
});

export const mutations = {
  sidebar(state, data) {
    state.drawerState = data;
  },
  updateProducts(state, products) {
    state.products = products;
  },
  addToCart(state, product) {
    let productInCartIndex = state.cart.findIndex(
      item => item.id == product.id
    );
    if (productInCartIndex != -1) {
      state.cart[productInCartIndex].quantity += product.quantity;
      return;
    }
    product.quantity = product.quantity;
    state.cart.push(product);
  },
  removeFromCart(state, index) {
    state.cart.splice(index, 1);
  },
  updateOrder(state, order) {
    state.order = order;
  },
  updateUser(state, user) {
    state.user = user;
  },
  updateCart(state, cart) {
    state.cart = cart;
  }
};

export const actions = {
  clearCart({ commit }) {
    commit("updateCart", []);
  }
};

export const getters = {
  drawerState: state => state.drawerState
};

// export default () => {
//   return new Vuex.Store({
//     state: {
//       products: [],
//       cart: [],
//       order: [],
//       user: [],
//       drawerState: false
//     },
//     mutations: {
//       sidebar(state, data) {
//         state.drawerState = data;
//       },
//       updateProducts(state, products) {
//         state.products = products;
//       },
//       addToCart(state, product) {
//         let productInCartIndex = state.cart.findIndex(
//           item => item.id == product.id
//         );
//         if (productInCartIndex != -1) {
//           state.cart[productInCartIndex].quantity++;
//           return;
//         }
//         product.quantity = 1;
//         state.cart.push(product);
//       },
//       removeFromCart(state, index) {
//         state.cart.splice(index, 1);
//       },
//       updateOrder(state, order) {
//         state.order = order;
//       },
//       updateUser(state, user) {
//         state.user = user;
//       },
//       updateCart(state, cart) {
//         state.cart = cart;
//       }
//     },
//     actions: {
//       clearCart({ commit }) {
//         commit("updateCart", []);
//       }
//     },
//     getters: {
//       drawerState: state => state.drawerState
//     }
//   });
// };
