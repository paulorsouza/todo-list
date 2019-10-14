import moment from 'moment';

const smallestDiff = (minutes) => {
  if (minutes < 60) return 'minutes';
  if (minutes < 1440) return 'hours';
  if (minutes < 10080) return 'days';
  if (minutes < 43800) return 'weeks';
  if (minutes < 525600) return 'months';
  return 'years';
};

const timeAgo = (date) => {
  const now = moment.utc();
  const momentDate = moment.utc(date);
  const minutes = now.diff(momentDate, 'minutes');
  const unit = smallestDiff(minutes);
  const diff = now.diff(momentDate, unit);
  if (diff <= 1) {
    return `1 ${unit.slice(0, -1)} ago`;
  }
  return `${diff} ${unit} ago`;
};

export { smallestDiff, timeAgo };
