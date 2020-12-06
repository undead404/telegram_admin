import React, { ChangeEvent, FocusEvent, useCallback } from 'react';

export default function MultiMessageTextarea({
  attributeName,
  i,
  maxLength,
  onBlur,
  onChange,
  value,
}: {
  attributeName: string;
  i: number;
  maxLength: number;
  onBlur: (event: FocusEvent<HTMLTextAreaElement>) => void;
  onChange: (newValue: string, index: number) => void;
  value: string;
}): JSX.Element {
  const handleChange = useCallback(
    (event: ChangeEvent<HTMLTextAreaElement>) => {
      if (event.target.value.length > event.target.maxLength) {
        return;
      }
      onChange(event.target.value, i);
    },
    [i, onChange],
  );
  return (
    <textarea
      defaultValue={value}
      id={`${attributeName}-${i + 1}`}
      maxLength={maxLength}
      name={`${attributeName}[]`}
      onBlur={onBlur}
      onChange={handleChange}
    />
  );
}
