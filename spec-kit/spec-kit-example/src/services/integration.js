// src/services/integration.js
// Integrate album/photo services with SQLite access layer (skeleton)

import { AlbumService } from './albumService.js';
import { PhotoService } from './photoService.js';
import { SQLite } from '../lib/sqlite.js';

export function createIntegratedServices(dbFilePath) {
  const db = new SQLite(dbFilePath);
  const albumService = new AlbumService(db);
  const photoService = new PhotoService(db);
  return { albumService, photoService };
}
