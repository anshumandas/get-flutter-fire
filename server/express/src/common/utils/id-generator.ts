
import slugify from "slugify";
// create uuid
export const uuid = (name: string, time: number, yyyymmdd = false, id: string) => {
    if(time) {
      //Strategy: Combining the time in milli-secs  and converting into 36 radix and adding 6 random alphanumeric to take care of concurrency if any
      const dateString = new Date(time - ((new Date()).getTimezoneOffset() * 60000 )).toISOString().split("T")[0]; //in yyyy-mm-dd
      const timeString = time.toString(36);
      const dateTime = (yyyymmdd ? (dateString + 'A' + timeString.substring(2)) : timeString); //A is used as a reserved character that is used for ranking. This allows us to have bottom 10 and top 25 added on daily basis
      if(!name) {
        //padding is not required as only 8 digits from now to 100 years later required
        return dateTime + (id ? id.substring(id.length - 6): Math.random().toString(36).substring(2, 8));
      }
      return dateTime + slugify(name); //this will sort all keys by time first and then their names
    }
    return slugify(name);
  };
  