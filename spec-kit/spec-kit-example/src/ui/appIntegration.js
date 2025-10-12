// src/ui/appIntegration.js
// Integrate UI with services for full user flow (skeleton)

import { createIntegratedServices } from '../services/integration.js';
import { AlbumList } from './AlbumList.js';
import { PhotoTiles } from './PhotoTiles.js';

export function initializeAppUI(container, dbFilePath) {
  const { albumService, photoService } = createIntegratedServices(dbFilePath);
  const albumList = new AlbumList(container, albumService);
  // TODO: Connect albumList and PhotoTiles for full user flow
  // e.g., albumList.onSelect = (album) => ...
  // const photoTiles = new PhotoTiles(photoContainer, photoService);
  throw new Error('Not implemented');
}
