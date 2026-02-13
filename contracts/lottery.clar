;; Simple Lottery Contract

(define-map tickets { player: principal } { amount: uint })
(define-data-var total-tickets uint u0)

(define-public (buy-ticket (amount uint))
  (begin
    (let ((current (default-to u0 (get amount (map-get? tickets { player: tx-sender })))))
      (map-set tickets { player: tx-sender } { amount: (+ current amount) })
      (var-set total-tickets (+ (var-get total-tickets) amount))
    )
    (ok "Ticket purchased")
  )
)

(define-read-only (get-tickets (player principal))
  (default-to u0 (get amount (map-get? tickets { player })))
)

(define-read-only (get-total-tickets)
  (var-get total-tickets))
