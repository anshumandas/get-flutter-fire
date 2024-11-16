
export const convertUrlToKey = (...params: string[]) => {
    var ret = '';
    for (let index = 0; index < params.length; index++) {
      const suffix = params[index];
      ret = (suffix?.startsWith(ret)) ? suffix : ret + suffix;
      ret = (ret.endsWith('#')) ? ret : ret + '#';
    }
    return ret;
  };

export function getId(pk:string) {
    return pk.substring(pk.indexOf('#') + 1, pk.length - 1);
}  