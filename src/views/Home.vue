<template>
  <div class="mx-auto max-w-3xl p-2 text-left">
    <h1 class="mt-2 mb-2 text-xl font-bold">Fully On-Chain Generative Art</h1>
    <p class="mb-2">
      This is a website for developers who are interested in
      <b>on-chain generative art</b>, which means
      <u>you write Solidity code to generate art in SVG format</u>.
    </p>
    <p class="mb-2">
      Unlike images stored on HTTP servers or IPFS, on-chain generative arts are
      truly decentralized and composable and can generate revenue autonomously
      (we will release a <b>decentralized autonomous marketplace</b> of
      generative arts soon).
    </p>
    <p class="mb-2">
      Because this is such a new field, I am going to guide you to get there
      step by step.
    </p>
    <h1 class="mt-2 mb-2 text-xl font-bold">TypeScript/Javascript Prototype</h1>
    <p class="mb-2">
      First of all, please learn how to write JavaScript/TypeScript code to
      generate art in SVG format, which helps you to understand what it takes to
      generate art in SVG format. It also helps you to refine your algorithm
      quickly (it takes a long time to do it in Solidity).
    </p>
    <p class="mb-2">Please run the following commands in your terminal.</p>
    <pre
      class="mb-2 rounded-md border border-gray-600 bg-gray-200 bg-opacity-60"
    >
      git clone git@github.com:Cryptocoders-wtf/generative.git
      cd generative
      yarn install
      yarn run serve</pre
    >
    <p class="mb-2">
      Then, open <code class="bg-gray-200">"localhost:8080"</code> in your
      browser. You'll see the clone of this website.
    </p>
    <p class="mb-2">
      Read <code class="bg-gray-200">src/views/Splatter.vue</code>, and learn
      how it works (please go to the Splatter page to see its output). It
      generates a series of <i>control points</i>, generates an SVG path from
      them, and generates an SVG image.
    </p>
    <p class="mb-2">
      Once you understand it, duplicate Splatter.vue file, and party on it. You
      need to modify <code class="bg-gray-200">src/router/index.ts</code> and
      <code class="bg-gray-200">src/components/Header.vue</code> appropriately
      to add your vue to the menu.
    </p>
    <h1 class="mt-2 mb-2 text-xl font-bold">Porting it to Solidity</h1>
    <p class="mb-2">
      The Soidity version of Splatter is avaiable at
      <code class="bg-gray-200">contract/contracts/SplatterProvider.sol</code>.
      Please compare it to TypeScript version. Although there are some
      differences because of languages, they are build with the same algorithm
      and similar libraries.
    </p>
    <p class="mb-2">
      Please notice that the Solidity version generates art deterministically
      based on the given assetId. This is why some internal functions takes
      Randomizer.seed as the first parameter and returns the updated one, which
      creates a pseudo state variable (or a closure) in read-only methods.
    </p>
    <p class="mb-2">
      The Solidity verison also pre-allocate memory (<code class="bg-gray-200"
        >points</code
      >) instead of dynamically push elements into the array, which is also
      necessary to keep those methods read-only.
    </p>
    <p class="mb-2">
      Please join
      <a href="https://discord.gg/4JGURQujXK" class="underline">our discord</a>,
      and feel free to ask any questions either in English or Japanese.
    </p>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
export default defineComponent({
  setup() {
    return {};
  },
});
</script>
