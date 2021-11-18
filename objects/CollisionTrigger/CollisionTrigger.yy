{
  "spriteId": {
    "name": "spr_obj_collision_trigger",
    "path": "sprites/spr_obj_collision_trigger/spr_obj_collision_trigger.yy",
  },
  "solid": false,
  "visible": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": null,
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":3,"value":"False","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"GroundOnly","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":6,"value":"\"None\"","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[
        "\"None\"",
        "\"To LayerA\"",
        "\"To LayerB\"",
      ],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"LeftDirection","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":6,"value":"\"None\"","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[
        "\"None\"",
        "\"To LayerA\"",
        "\"To LayerB\"",
      ],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"RightDirection","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [],
  "parent": {
    "name": "Stage Objects",
    "path": "folders/Game Objects/Stage Objects.yy",
  },
  "resourceVersion": "1.0",
  "name": "CollisionTrigger",
  "tags": [],
  "resourceType": "GMObject",
}