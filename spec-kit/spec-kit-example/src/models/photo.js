// src/models/photo.js
// Photo model (skeleton)

export class Photo {
  constructor({ id = null, albumId, filePath, thumbnailPath = '', metadata = {} }) {
    this.id = id;
    this.albumId = albumId;
    this.filePath = filePath;
    this.thumbnailPath = thumbnailPath;
    this.metadata = metadata;
  }
}
