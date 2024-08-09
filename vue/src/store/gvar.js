import { reactive } from 'vue';

export const globalState = reactive({
    totalPrices: 0
});

export const updateTotalPrice = (newTotal) => {
    globalState.totalPrices = newTotal;
};