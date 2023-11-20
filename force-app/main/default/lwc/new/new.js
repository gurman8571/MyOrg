import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";


export default class New extends LightningElement { 
    @api invoke() {
    console.log("Hi, I'm an action.");
    let event = new ShowToastEvent({
        title: "I am a headless action!",
        message: "Hi there! Starting...",
      });
      this.dispatchEvent(event);
  }}