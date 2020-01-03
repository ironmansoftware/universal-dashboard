import React from 'react'
import toaster from './toaster'
import { useClipboard } from 'use-clipboard-copy';

export default function setUDClipboard(data, toastOnSuccess, toastOnError) {
    const clipboard = useClipboard({
        onSuccess() {
            toastOnSuccess
                ? toaster.show({ message: 'Copied to clipboard' })
                : console.log('Text was copied successfully!', data)
        },
        onError() {
            toastOnError
                ? toaster.show({ message: 'Unable to copy to clipboard' })
                : console.log('Failed to copy text!')
        }
    });
    clipboard.isSupported()
        ? "yay! copy-to-clipboard is supported"
        : "meh. copy-to-clipboard is not supported switching to execCommand('copy')"

    clipboard.copy(data)
    return null
}