// src/services/albumService.js
// Album service (skeleton)

import { Album } from '../models/album.js';

export class AlbumService {
  constructor(db) {
    this.db = db; // SQLite access layer
  }

  async createAlbum({ date, title }) {
    // TODO: Implement album creation logic
    throw new Error('Not implemented');
  }

  async reorderAlbums(orderList) {
    // TODO: Implement album reordering logic
    throw new Error('Not implemented');
  }

  async preventNesting() {
    // TODO: Implement logic to prevent album nesting
    throw new Error('Not implemented');
  }
}
