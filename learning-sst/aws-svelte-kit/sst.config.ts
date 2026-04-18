/// <reference path="./.sst/platform/config.d.ts" />

export default $config({
	app(input) {
		return {
			name: 'aws-svelte-kit',
			removal: input?.stage === 'production' ? 'retain' : 'remove',
			protect: ['production'].includes(input?.stage),
			home: 'aws',
			providers: {
				aws: {
					region: 'ap-northeast-1',
					profile: 'mg0515'
				}
			}
		};
	},
	async run() {
		const bucket = new sst.aws.Bucket('MyBucket', {
			access: 'public'
		});
		new sst.aws.SvelteKit('MyWeb', {
			link: [bucket]
		});
	}
});
