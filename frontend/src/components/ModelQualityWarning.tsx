import { Sparkles } from 'lucide-react';
import styles from './ModelQualityWarning.module.css';

export function ModelQualityWarning() {
  return (
    <div className={styles.container} role="status">
      <Sparkles className={styles.icon} aria-hidden="true" />
      <p className={styles.message}>
        AI formatting applied: filler words removed and grammar refined.
      </p>
    </div>
  );
}
