export type RecentTracksResponse = {
  recenttracks: RecentTracks;
};

export type RecentTracks = {
  track: Track[];
};

export type Track = {
  name: string;
  url: string;
  image: TrackImage[];
  artist: { "#text": string };
  album: { "#text": string };
  "@attr"?: TrackAttr;
};

export type TrackImage = {
  size: "small" | "medium" | "large" | "extralarge";
  "#text": string;
};

export type TrackAttr = {
  nowplaying?: boolean;
};
