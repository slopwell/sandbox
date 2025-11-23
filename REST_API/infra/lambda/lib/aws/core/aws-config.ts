import { fromEnv, fromIni } from "@aws-sdk/credential-providers";
import type {
  AwsCredentialIdentity,
  AwsCredentialIdentityProvider,
} from "@aws-sdk/types";
import { coalesce, isNotEmpty, strip } from "~/util/strings";

export declare type CredentialIdentity =
  | AwsCredentialIdentityProvider
  | AwsCredentialIdentity;

const DEFAULT_REGION = "ap-northeast-1";

function getCredentials(): CredentialIdentity {
  const profile = strip(process.env.AWS_PROFILE);
  if (profile.length > 0) {
    return fromIni({ profile });
  } else {
    return fromEnv();
  }
}

/**
 * 環境変数からリージョンを取得する。
 * 取れなかったら「{@link DEFAULT_REGION}」を返す。
 * @private
 */
function getRegion(): string {
  return (
    coalesce(
      strip(process.env.AWS_REGION),
      strip(process.env.AWS_DEFAULT_REGION)
    ) ?? DEFAULT_REGION
  );
}

function getConfig(): AwsConfig.AwsConfigFragment {
  const config: AwsConfig.AwsConfigFragment = {
    credentials: getCredentials(),
    region: getRegion(),
  };

  if (isNotEmpty(process.env.AWS_ENDPOINT)) {
    config.endpoint = process.env.AWS_ENDPOINT;
  }

  return config;
}

export const AwsConfig = {
  /**
   * @deprecated insted use {@link AwsConfig.config}
   */
  get credentials() {
    return getCredentials();
  },
  /**
   * @deprecated insted use {@link AwsConfig.config}
   */
  get region() {
    return getRegion();
  },
  get config() {
    return getConfig();
  },
} as const;

export declare namespace AwsConfig {
  export interface AwsConfigFragment {
    credentials: CredentialIdentity;
    region: string;
    endpoint?: string;
  }
}
