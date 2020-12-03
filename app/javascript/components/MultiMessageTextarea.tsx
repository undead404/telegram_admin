import React, { ChangeEvent, FocusEvent, useCallback } from "react";

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
  onChange: (newValue: string, i: number) => void;
  value: string;
}) {
  const handleChange = useCallback(
    (event: ChangeEvent<HTMLTextAreaElement>) => {
      onChange(event.target.value, i);
    },
    [i]
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
