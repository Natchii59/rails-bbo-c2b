import {Ability} from '@casl/ability'

export const ability = new Ability()

export const abilityPlugin = (store) => {
  return store.subscribe(mutation => {
    if (mutation.type === 'auth/setUser') {
      console.log(mutation.payload)
      ability.update(mutation.payload ? mutation.payload.rules : {})
    }
  })
}
