<template>
  <div class="mx-auto max-w-3xl p-2 text-left">
    <p class="mb-2">
      Images from TypeScript prototype. {{ $t("message.touchToUpdate") }}
    </p>
    <div @click="updateImages">
      <img
        v-for="image in images"
        :key="image"
        :src="image"
        class="mr-1 mb-1 inline-block w-20"
      />
    </div>
    <Mint :network="network" :tokenAddress="tokenAddress" />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import { useRoute } from "vue-router";
import { sampleColors } from "@/models/point";
import { generateSVGImage } from "@/generative/splatter";
import Mint from "@/components/Mint.vue";
import { addresses as mainnet } from "@/utils/addresses/splatter_mainnet";
import { addresses as localhost } from "@/utils/addresses/splatter_localhost";
import { addresses as rinkeby } from "@/utils/addresses/splatter_rinkeby";
import { addresses as goerli } from "@/utils/addresses/splatter_goerli";

const allAddresses: any = {
  mainnet,
  localhost,
  rinkeby,
  goerli,
};

export default defineComponent({
  components: {
    Mint,
  },
  setup() {
    const route = useRoute();
    const network =
      typeof route.query.network == "string" ? route.query.network : "goerli";
    const addresses = allAddresses[network];
    const tokenAddress = addresses.splatterToken;
    console.log("*** chainId", network, tokenAddress);
    const images = ref<string[]>([]);
    const updateImages = () => {
      // sampleColorsの色数でループ。その色colorをgenerateSVGImageへ渡してSVGイメージを生成している
      images.value = sampleColors.map((color) => generateSVGImage(color));
    };
    updateImages();
    return {
      images,
      updateImages,
      network,
      tokenAddress,
    };
  },
});
</script>
