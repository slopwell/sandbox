// src/models/album.js
// Album model (skeleton)

export class Album {
  constructor({ id = null, date, title = '', orderIndex = 0, photos = [] }) {
    this.id = id;
    this.date = date;
    this.title = title;
    this.orderIndex = orderIndex;
    this.photos = photos;
  }
}
