<template>
	<main>
		<div class="greeting-card">
			<h1>{{ message }}</h1>
			<p>It's good to see you again!</p>
		</div>

		<div class="calendar-widget centered large-text">
			Calendar
		</div>
		<div class="events-widget centered large-text">
			Events
		</div>
		<div class="booking-widget centered large-text">
			Create Booking
		</div>
	</main>
</template>

<script>
export default {
	name: 'App',
	data() {
		return {
			message: 'Hello Joao!',
		};
	},
};
</script>

<style scoped>

	.centered {
		height: 100%;
		display: flex;
		justify-content: center;
		align-content: center;
	}

	.large-text {
		font-size: 1.5rem;
	}

	main {
		background-color: #e6e4e4;
		width: 100%;
		height: 100vh;
		padding: 20px;
		display: grid;
		gap: 20px;
		grid-template-columns: 1fr 1fr;
		grid-template-rows: 1fr 3fr 2fr;
	}

	.greeting-card {
		background-color:lightblue;
		grid-column-start: 1;
		grid-column-end: 3;
		grid-row-start: 1;
		grid-row-end: 2;
	}

	.calendar-widget {
		background-color:azure;
		grid-column-start: 1;
		grid-column-end: 2;
		grid-row-start: 2;
		grid-row-end: 3;
	}

	.events-widget {
		background-color: lightpink;
		grid-column-start: 2;
		grid-column-end: 3;
		grid-row-start: 2;
		grid-row-end: 3;
	}

	.booking-widget {
		background-color: bisque;
		grid-column-start: 1;
		grid-column-end: 3;
		grid-row-start: 3;
		grid-row-end: 4;
	}
</style>
