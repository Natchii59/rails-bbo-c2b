import Vue from "vue";
import VueRouter from "vue-router";

import store from "./store";

import Home from "./views/home";
import Product from "./views/products/products";
import ProductEdit from "./views/products/product-edit";
import ProductShow from "./views/products/product-show";
import ProductNew from "./views/products/product-new";
import Widgets from "./views/widgets/widgets";
import WidgetShow from "./views/widgets/widget-show";
import WidgetNew from "./views/widgets/widget-new";
import WidgetEdit from "./views/widgets/widget-edit";
import Login from "./views/user/login";
import {ability} from "./store/ability";
import Multiguard from "vue-router-multiguard";

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/products',
      name: 'Products',
      component: Product,
      meta: {resource: 'Product'}
    },
    {
      path: '/products/new',
      name: 'ProductNew',
      component: ProductNew,
      meta: {resource: 'Product'}
    },
    {
      path: '/products/:id',
      name: 'ProductShow',
      component: ProductShow,
      props: true,
      meta: {resource: 'Product'}
    },
    {
      path: '/products/:id/edit',
      name: 'ProductEdit',
      component: ProductEdit,
      props: true,
      meta: {resource: 'Product'}
    },
    {
      path: '/widgets',
      name: 'Widgets',
      component: Widgets
    },
    {
      path: '/widgets/new',
      name: 'WidgetNew',
      component: WidgetNew
    },
    {
      path: '/widgets/:id',
      name: 'WidgetShow',
      component: WidgetShow,
      props: true
    },
    {
      path: '/widgets/:id/edit',
      name: 'WidgetEdit',
      component: WidgetEdit,
      props: true
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta: {
        requireNoAuth: true
      }
    }
  ]
})

const requireNoAuth = async (to, from, next) => {
  if (store.getters['auth/user']) next({path: '/'})
  else {
    await store.dispatch('auth/loginSession')
    if (store.getters['auth/user'] && !store.getters['auth/error']) next({path: '/'})
    else next()
  }
}

const requireAuth = async (to, from, next) => {
  if (!store.getters['auth/user']) {
    await store.dispatch('auth/loginSession').then(() => {
      if (!store.getters['auth/error']) {
        next()
      } else {
        next({
          path: '/login',
          query: {redirect: to.fullPath}
        })
      }
    })
  } else {
    next()
  }
}

const authorizeUser = (to, from, next) => {
  if (to.path !== '/login' && to.path !== '/' && to.meta.resource) {
    const canNavigate = to.matched.some(route => {
      return ability.can(route.meta.action || 'read', route.meta.resource)
    })

    if (!canNavigate) {
      if (from.path === '/') {
        next('/')
      } else {
        next(false)
      }
    } else {
      next()
    }
  } else {
    next()
  }
}

router.beforeEach(async (to, from, next) => {
  if (to.matched.some(record => record.meta.requireNoAuth)) {
    return await requireNoAuth(to, from, next)
  } else {
    return await Multiguard([requireAuth, authorizeUser])(to, from, next)
  }
})

export default router;
