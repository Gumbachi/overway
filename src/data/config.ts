import { exec, monitorFile, readFile, Variable } from "astal";

const home = exec("bash -c 'echo $HOME'")
export const configPath = `${home}/.config/overway/config.json`
export const defaultConfig = { 
  "showWidgetTitles": false,

  "scratchpad": [
    {
      "id": 0,
      "name": "Counter",
      "type": "counter",
      "persistValue": false
    },
    {
      "id": 1,
      "name": "Note",
      "type": "note",
      "persistValue": false
    }
  ]
}

export const showVolumeMixer = Variable(false)

export let config = JSON.parse(readFile(configPath))

monitorFile(configPath, (file, event) => {
  print(file)
  print(event)
  if (event === 0) {
    config = JSON.parse(readFile(configPath))
  }
})

