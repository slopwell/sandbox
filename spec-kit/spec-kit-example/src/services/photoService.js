// src/services/photoService.js
// Photo service (skeleton)

import { Photo } from '../models/photo.js';

export class PhotoService {
  constructor(db) {
    this.db = db; // SQLite access layer
  }

  async addPhoto({ albumId, filePath, thumbnailPath, metadata }) {
    // TODO: Implement photo addition logic
    throw new Error('Not implemented');
  }

  async previewPhotos(albumId) {
    // TODO: Implement photo preview logic
    throw new Error('Not implemented');
  }

  async deduplicatePhotos(albumId) {
    // TODO: Implement duplicate photo handling
    throw new Error('Not implemented');
  }
}
