<script lang="ts">
  import type { RecentTracksResponse } from "@/types/lastfm";

  type Props = { apiKey: string };

  const RELOAD_TIME = 10 * 1_000;
  const { apiKey }: Props = $props();

  let track = $state<Awaited<ReturnType<typeof loadLatestTrack>>>();

  async function loadLatestTrack() {
    const url = new URL("http://ws.audioscrobbler.com/2.0");
    url.searchParams.set("method", "user.getrecenttracks");
    url.searchParams.set("user", "quinnputer");
    url.searchParams.set("api_key", apiKey);
    url.searchParams.set("format", "json");
    url.searchParams.set("limit", "1");

    const response = await fetch(url);
    const body = (await response.json()) as RecentTracksResponse;
    const track = body.recenttracks.track[0];

    const image =
      track.image.find((i) => i.size === "extralarge") ?? track.image[0];

    return {
      currentlyPlaying: track["@attr"]?.nowplaying,
      title: `${track.artist["#text"]} - ${track.name}`,
      image: image["#text"],
      url: track.url,
    };
  }

  $effect(() => {
    async function fetchData() {
      track = await loadLatestTrack();
      setTimeout(fetchData, RELOAD_TIME);
    }

    fetchData();
  });
</script>

<svelte:element
  this={track ? "a" : "div"}
  href={track?.url}
  target="_blank"
  class="no-underline hover:text-foreground hover:border-highlight flex items-center justify-between w-full min-w-0 bg-section-background border border-solid border-section-border"
>
  <div class="px-2 md:px-4 lg:px-6 flex-1 min-w-0">
    <h1 class="text-base md:text-lg lg:text-2xl mb-1">
      {track?.currentlyPlaying ? "Currently listening to" : "Most recent track"}
    </h1>

    <p
      class="text-foreground-darker text-sm max-w-full truncate md:text-base lg:text-lg w-full"
    >
      {track?.title ?? "Loading..."}
    </p>
  </div>

  <img
    class="size-20 md:size-30 lg:size-40 shrink-0 object-cover"
    src={track?.image ?? "/images/loading.gif"}
    alt={track?.title ?? "Loading"}
  />
</svelte:element>
